require 'bundler/gem_tasks'

# Build the version of video.js and tag us to match

VIDEO_JS_RAILS_HOME = File.expand_path(File.dirname(__FILE__))
VIDEO_JS_HOME = File.expand_path('../video.js', VIDEO_JS_RAILS_HOME)

VIDEO_JS_RAKE_USAGE = "Usage: rake videojs:update TAG=v4.12.5"

namespace :videojs do
  task :update => [:build, :commit]

  task :build do
    tag = ENV['TAG'] or abort VIDEO_JS_RAKE_USAGE
    Dir.chdir(VIDEO_JS_HOME) do
      puts "* Building video.js #{tag} using grunt"
      unless ENV['NOBUILD']
        sh "git checkout -q master"
        sh "git pull -q"
        sh "git checkout -q #{tag}"
        sh "grunt"
      end

      # Copy files into our Rails structure
      puts
      puts "* Copying files to vendor/assets"
      sh "cp #{VIDEO_JS_HOME}/dist/video-js/font/* #{VIDEO_JS_RAILS_HOME}/vendor/assets/fonts/"
      sh "cp #{VIDEO_JS_HOME}/dist/video-js/video-js.css #{VIDEO_JS_RAILS_HOME}/vendor/assets/stylesheets/"
      sh "cp #{VIDEO_JS_HOME}/dist/video-js/video-js.swf #{VIDEO_JS_RAILS_HOME}/vendor/assets/javascripts/"
      sh "cp #{VIDEO_JS_HOME}/dist/video-js/video.dev.js #{VIDEO_JS_RAILS_HOME}/vendor/assets/javascripts/"

      # Now, perform some asset_path and other substitutions
      puts
      puts "* Updating videojs-css.erb for Rails asset pipeline"
      css = "#{VIDEO_JS_RAILS_HOME}/vendor/assets/stylesheets/video-js.css"
      File.open("#{css}.erb", 'w') do |out|
        File.foreach(css) do |line|
          # Handle fonts => url('<%= asset_path('vjs.woff') %>') format('woff')
          out <<
            line.gsub(/url\(('*)font\/(vjs[^\)]+)\)(\s+format[^\)]+\))?/, 'url(<%= asset_path(\1\2) %>)\3')
        end
      end
      sh "rm -f #{css}"

      puts
      puts "* Updating video.js.erb for Rails asset pipeline"
      jsdev = "#{VIDEO_JS_RAILS_HOME}/vendor/assets/javascripts/video.dev.js"
      jserb = "#{VIDEO_JS_RAILS_HOME}/vendor/assets/javascripts/video.js.erb"
      File.open(jserb, 'w') do |out|
        File.foreach(jsdev) do |line|
          # Handle swf => asset_path('video-js.swf')
          out <<
            line.sub(/(videojs\.options\['flash'\]\['swf'\]\s*=\s*).*/, %q(\1"<%= asset_path('video-js.swf') %>";))
        end
      end
      sh "rm -f #{jsdev}"
      sh "rm -f #{VIDEO_JS_RAILS_HOME}/vendor/assets/javascripts/video.js"
    end
  end

  task :commit do
    tag = ENV['TAG'] or abort VIDEO_JS_RAKE_USAGE

    # Update the gem version
    version_file = "#{VIDEO_JS_RAILS_HOME}/lib/videojs_rails/version.rb"
    lines = File.read(version_file)
    File.open(version_file, 'w') do |out|
      version_num = tag.sub(/^v/,'')  # lose the "v" from the tag
      puts "* Setting gem version = #{version_num}"
      out << lines.sub(/(VERSION\s*=\s*)\S+/, "\\1'#{version_num}'")
    end

    sh "git add ."
    sh "git commit -m 'Update to video.js #{tag}'"
    puts "* Done.  Now run 'rake release' to push to rubygems."
  end
end