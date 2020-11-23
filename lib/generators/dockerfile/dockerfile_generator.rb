class DockerfileGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  class_option :database, type: :string, default: "default", desc: "Database libs to be installed inside Docker image."

  def create_dockerfile
    puts "Database: #{options[:database]}"
    default_ruby_version = ruby_version
    default_bundler_version = bundler_version
    libs = build_libs
    template "Dockerfile.erb", "Dockerfile", context: binding
  end

  def create_dockerignore
    template "dockerignore.erb", ".dockerignore"
  end

  private

  def build_libs
    libs = []
    case options[:database]
    when 'sqlite'
      libs += ['libsqlite3-dev']
    when 'pg', 'postgres'
      libs += ['libpq-dev']
    end
    libs
  end

  def ruby_version
    RUBY_VERSION
  end

  def bundler_version
    bundler_config.bundler_version.version
  end

  def bundler_config
    Bundler::LockfileParser.new(Bundler.read_file(Bundler.default_lockfile))
  end
end
