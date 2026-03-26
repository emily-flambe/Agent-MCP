# Wait for network
Start-Sleep -Seconds 10

# Start Ollama if not already running
$ollamaRunning = Get-Process -Name 'ollama' -ErrorAction SilentlyContinue
if (-not $ollamaRunning) {
    Start-Process -FilePath 'C:\Users\emily\AppData\Local\Programs\Ollama\ollama.exe' -ArgumentList 'serve' -WindowStyle Hidden
    Start-Sleep -Seconds 5
}

# Start Agent-MCP server
$agentMcpDir = 'C:\Users\emily\Documents\Github\Agent-MCP\agent-mcp-node'
$env:AGENT_MCP_SKIP_TUI = 'true'
$env:EMBEDDING_PROVIDER = 'ollama'
$env:OLLAMA_MODEL = 'qwen3-embedding:0.6b'
$env:OLLAMA_URL = 'http://localhost:11434'
$env:OPENAI_API_KEY = 'ollama'
$env:OPENAI_BASE_URL = 'http://localhost:11434/v1'
$env:OPENAI_MODEL = 'qwen3-embedding:0.6b'
$env:EMBEDDING_DIMENSIONS = '1024'
$env:MCP_PROJECT_DIR = 'C:\Users\emily\Documents\Github'
Start-Process -FilePath 'node' -ArgumentList 'build/examples/server/agentMcpServer.js','--mode','memoryRag','--project-dir','C:/Users/emily/Documents/Github','--no-tui','--port','8080' -WorkingDirectory $agentMcpDir -WindowStyle Hidden
