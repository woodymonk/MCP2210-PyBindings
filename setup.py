#!/usr/bin/env python

"""
setup.py file for MCP2210 PyBindings
"""

from distutils.core import setup, Extension

mcp2210_module = Extension('_mcp2210',
                           sources=['hid.c','mcp2210_wrap.cxx', 'mcp2210.cpp'],
                           extra_link_args=['-ludev'])



setup (name = 'mcp2210',
       version = '0.1',
       author      = "Woody Monk",
       description = """MCP2210 Python Bindings""",
       ext_modules = [mcp2210_module],
       py_modules = ["mcp2210"],
       )

