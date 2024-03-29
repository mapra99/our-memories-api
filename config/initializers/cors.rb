# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  if Rails.env.development?
    allow do
      origins 'studio.apollographql.com'

      resource '/graphql',
        headers: :any,
        methods: [:get, :post, :put, :patch, :delete, :options, :head]
    end

    allow do
      origins 'http://localhost:3000'
      resource '*',
        headers: :any,
        methods: [:get, :post, :put, :patch, :delete, :options, :head]
    end
  end

  allow do
    origins /\Ahttps?:\/\/(deploy-preview-.*)?our-memories-main\.netlify\.app\z/
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end

  if Rails.env.production?
    allow do
      origins ENV.fetch('FRONTEND_APP_URL')
      resource '*',
        headers: :any,
        methods: [:get, :post, :put, :patch, :delete, :options, :head]
    end

    # Review apps coming from monolith
    allow do
      origins /https:\/\/om-monolith-pr-\d+\.herokuapp\.com/
      resource '*',
        headers: :any,
        methods: [:get, :post, :put, :patch, :delete, :options, :head]
    end
  end
end
