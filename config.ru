use Rack::Static,
  :urls => ["/images", "/js", "/css"],
  :root => "public"

class MainResponder
  def index env
    [
      200,
      {
        'Content-Type'  => 'text/html',
        'Cache-Control' => 'public, max-age=86400'
      },
      File.open('public/index.html', File::RDONLY)
    ]
  end

  def accelerometer env
    [
      200,
      {
        'Content-Type'  => 'text/html',
        'Cache-Control' => 'public, max-age=86400'
      },
      File.open('public/index.html', File::RDONLY)
    ]
  end

  def accelerometer env
    [
      200,
      {
        'Content-Type'  => 'text/html',
        'Cache-Control' => 'public, max-age=86400'
      },
      File.open('public/charts.html', File::RDONLY)
    ]
  end
end

def path_regex base = nil
  if nil
    # root path option leading /
    /^\/?$/
  else
    /^\/#{base}\/?$/
  end
end

run lambda { |env|
  responder = MainResponder.new
  path = env['PATH_INFO']

  if path_regex.match path
    responder.index env
  elsif path_regex('accelerometer').match(path)
    responder.accelerometer env
  elsif path_regex('charts').match(path)
    responder.accelerometer env
  else
    [404, {}, File.open('public/404.html', File::RDONLY)]
  end
}