#!/bin/bash
# Start Agent-MCP server with Ollama embeddings
# Run this before starting Claude Code sessions

# Start Ollama if not running
if ! curl -s http://localhost:11434/api/tags > /dev/null 2>&1; then
    echo "Starting Ollama..."
    "/c/Users/emily/AppData/Local/Programs/Ollama/ollama.exe" serve > /dev/null 2>&1 &
    sleep 3
fi

echo "Ollama status:"
"/c/Users/emily/AppData/Local/Programs/Ollama/ollama.exe" list 2>/dev/null

# Start Agent-MCP Node.js server
cd /c/Users/emily/Documents/Github/Agent-MCP/agent-mcp-node
AGENT_MCP_SKIP_TUI=true node build/examples/server/agentMcpServer.js \
    --mode memoryRag \
    --project-dir "C:/Users/emily/Documents/Github" \
    --no-tui \
    --port 8080
