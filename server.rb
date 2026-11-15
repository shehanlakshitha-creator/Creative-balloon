require 'webrick'

root = File.expand_path(__dir__)
port = 3000

mime_map = {
  '.html' => 'text/html; charset=utf-8',
  '.css'  => 'text/css; charset=utf-8',
  '.js'   => 'application/javascript; charset=utf-8',
  '.json' => 'application/json; charset=utf-8',
  '.svg'  => 'image/svg+xml',
  '.jpg'  => 'image/jpeg',
  '.jpeg' => 'image/jpeg',
  '.png'  => 'image/png',
  '.webp' => 'image/webp',
  '.ico'  => 'image/x-icon'
}

server = WEBrick::HTTPServer.new(
  Port: port,
  Logger: WEBrick::Log.new($stdout, WEBrick::Log::INFO),
  AccessLog: []
)

server.mount_proc '/' do |req, res|
  # Default to index.html for root path
  req_file = req.path == '/' ? '/index.html' : req.path
  safe_path = File.expand_path(File.join(root, req_file))

  # Security check and file existence
  if safe_path.start_with?(root) && File.file?(safe_path)
    ext = File.extname(safe_path).downcase
    res.content_type = mime_map[ext] || 'application/octet-stream'
    # Reading into string memory completely prevents macOS sendfile Errno::EPERM
    res.body = File.binread(safe_path)
  else
    # Try appending .html if not found (e.g. /services -> /services.html)
    alt_path = safe_path + '.html'
    if safe_path.start_with?(root) && File.file?(alt_path)
      res.content_type = 'text/html; charset=utf-8'
      res.body = File.binread(alt_path)
    else
      res.status = 404
      res.content_type = 'text/html; charset=utf-8'
      res.body = "<h1>404 Not Found</h1><p>Resource #{WEBrick::HTMLUtils.escape(req.path)} was not found.</p>"
    end
  end
end

trap('INT') { server.shutdown }
trap('TERM') { server.shutdown }

puts "=================================================="
puts "  CREATIVE BALLOON — LOCAL PREVIEW SERVER"
puts "  URL: http://localhost:#{port}"
puts "  Root: #{root}"
puts "=================================================="

server.start
