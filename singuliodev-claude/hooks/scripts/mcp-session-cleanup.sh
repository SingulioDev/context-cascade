#!/bin/bash
# MCP-Session-Cleanup.sh
# Reminder script for cleaning up situational MCPs after session

echo "=================================================="
echo "!! SESSION ENDING - MCP CLEANUP REMINDER !!"
echo "=================================================="
echo ""
echo "If you activated situational MCPs during this session,"
echo "consider deactivating them to reduce startup time:"
echo ""
echo "  # Remove all situational MCPs"
echo "  powershell -File C:/Users/17175/REMOVE-MCP.ps1 all-situational"
echo ""
echo "  # Or remove specific categories:"
echo "  powershell -File C:/Users/17175/REMOVE-MCP.ps1 code-quality"
echo "  powershell -File C:/Users/17175/REMOVE-MCP.ps1 automation"
echo ""
echo "Remember to restart Claude Desktop after changes."
echo "=================================================="
