-- Add a table for globally accessible variables to avoid name conflicts.
_G.MyGlobals = {}

-- Load configuration modules.
require 'core.basic_options'
require 'core.lazy_bootstrap'
