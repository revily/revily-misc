@current_recipe = nil
def current_recipe(recipe=nil)
  @current_recipe = recipe unless recipe.nil?
  return @current_recipe
end

@after_blocks = []
def after_bundler(&block)
  @after_blocks << block
end

@after_everything_blocks = []
def after_everything(&block)
  @after_everything_blocks << block
end

@before_configs = {}
def before_config(&block)
  @before_configs[@current_recipe] = block
end

puts self.class

def say_custom(tag, text)
  say "\033[1m\033[36m" + tag.to_s.rjust(10) + "\033[0m" + "  #{text}"
end

def say_recipe(name)
  say "\033[1m\033[36m" + "recipe".rjust(10) + "\033[0m" + "  Running #{name} recipe..."
end

def say_wizard(text)
  say_custom(current_recipe || 'composer', text)
end

gem 'active_model_serializers',            github: 'rails-api/active_model_serializers'
gem 'metriks',                             '0.9.9.5'
gem 'dalli',                               '2.6.4'

gem 'request_store'

gem_group :development do
  gem 'guard-rspec',                        require: false
  gem 'guard-spork',                        require: false
  gem 'guard-shell',                        require: false
  gem 'libnotify',                          require: false
  gem 'method_profiler',                    require: false
  gem 'perftools.rb',                       require: false
  gem 'pry-rails'
  gem 'rblineprof',                         require: false
  gem 'rbtrace',                            require: false
  gem 'rb-fsevent',                         require: false
  gem 'rb-inotify',                         require: false
  gem 'ruby-graphviz',                      require: false
  gem 'ruby-prof',                          require: false
  gem 'ruby_gntp',                          require: false
  gem 'spork-rails',                        require: false, github: 'sporkrb/spork-rails'
end

gem_group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'json_spec'
  gem 'rspec-rails'
  gem 'shoulda-matchers',                   require: false
  gem 'timecop'
  gem 'webmock'
  gem 'vcr'
end

gem_group :development, :test do
  gem 'awesome_print'
  gem 'factory_girl_rails'
  gem 'forgery'
  gem 'sham_rack'
end

gem_group :staging, :production do
  gem 'airbrake'
  gem 'newrelic_rpm'
end

gem_group :doc do
  gem 'redcarpet'
  gem 'yard'
end

# git add: '.'
# git commit: '-qm "Updated Gemfile"'

gsub_file 'Gemfile', /#.*\n/, "\n"
gsub_file 'Gemfile', /\n^\s*\n/, "\n"
gsub_file 'config/routes.rb', /  #.*\n/, "\n"
gsub_file 'config/routes.rb', /\n^\s*\n/, "\n"

template 'files/NOTICE', 'NOTICE'
template 'files/LICENSE', 'LICENSE'
