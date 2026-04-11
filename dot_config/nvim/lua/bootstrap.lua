local uv = vim.uv or vim.loop

local M = {}

local config_dir = vim.fn.stdpath("config")
local lua_dir = config_dir .. "/lua"
local fnl_path = config_dir .. "/fnl/init.fnl"
local fnl_dir = config_dir .. "/fnl"
local compiled_path = lua_dir .. "/compiled.lua"
local compiler_path = lua_dir .. "/fennel.lua"
local source_hash_path = lua_dir .. "/.fnl.sha256"

local function read_file(path)
  local fd = assert(uv.fs_open(path, "r", 420))
  local stat = assert(uv.fs_fstat(fd))
  local data = assert(uv.fs_read(fd, stat.size, 0))
  assert(uv.fs_close(fd))
  return data
end

local function write_file(path, data)
  local fd = assert(uv.fs_open(path, "w", 420))
  assert(uv.fs_write(fd, data, 0))
  assert(uv.fs_close(fd))
end

local function file_exists(path)
  return uv.fs_stat(path) ~= nil
end

local function sha256(data)
  return vim.fn.sha256(data)
end

local function scandir(path, entries)
  entries = entries or {}

  local handle = uv.fs_scandir(path)
  if not handle then
    return entries
  end

  while true do
    local name, kind = uv.fs_scandir_next(handle)
    if not name then
      break
    end

    local full_path = path .. "/" .. name
    if kind == "directory" then
      scandir(full_path, entries)
    elseif kind == "file" and name:sub(-4) == ".fnl" then
      entries[#entries + 1] = full_path
    end
  end

  return entries
end

local function source_tree_hash()
  local files = scandir(fnl_dir, {})
  table.sort(files)

  local chunks = {}
  for _, path in ipairs(files) do
    chunks[#chunks + 1] = path:sub(#fnl_dir + 2)
    chunks[#chunks + 1] = "\0"
    chunks[#chunks + 1] = read_file(path)
    chunks[#chunks + 1] = "\0"
  end

  return sha256(table.concat(chunks))
end

local function compile_if_needed()
  local source_hash = source_tree_hash()

  local compiled_missing = not file_exists(compiled_path)
  local source_changed = compiled_missing
    or not file_exists(source_hash_path)
    or read_file(source_hash_path) ~= source_hash

  if not source_changed then
    return
  end

  package.path = table.concat({
    lua_dir .. "/?.lua",
    lua_dir .. "/?/init.lua",
    package.path,
  }, ";")

  package.loaded.fennel = nil

  local fennel = require("fennel")
  local old_fennel_path = fennel.path
  fennel.path = table.concat({
    fnl_dir .. "/?.fnl",
    fnl_dir .. "/?/init.fnl",
  }, ";")
  local compiled = fennel.compileString(read_file(fnl_path), {
    filename = fnl_path,
    requireAsInclude = true,
  })
  fennel.path = old_fennel_path

  write_file(compiled_path, compiled)
  write_file(source_hash_path, source_hash)
end

function M.load()
  compile_if_needed()
  package.loaded.compiled = nil
  require("compiled")
end

return M
