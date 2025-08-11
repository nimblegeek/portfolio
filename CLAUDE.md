# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Portfolio Builder is a Ruby on Rails application designed for creating drag-and-drop portfolio websites. This is the initial scaffolding with authentication and basic project management functionality.

## Technology Stack

- **Backend**: Ruby on Rails 8.0.2
- **Database**: SQLite3 (development)
- **Authentication**: Rails built-in `has_secure_password` with bcrypt
- **Frontend**: ERB templates with custom CSS
- **JavaScript**: Stimulus/Turbo (Hotwire)

## Development Commands

```bash
# Install dependencies
bundle install

# Database operations
rails db:create          # Create database
rails db:migrate         # Run migrations
rails db:seed           # Seed database (if seeds exist)
rails db:reset          # Drop, create, migrate, and seed

# Development server
rails server            # Start server on http://localhost:3000
rails server -p 3001    # Start server on custom port

# Console and testing
rails console           # Rails console for debugging
rails test             # Run test suite
rails test:system      # Run system tests

# Code quality
rails routes           # View all routes
bin/rubocop           # Run RuboCop linting
bin/brakeman          # Run security analysis
```

## Project Architecture

### Models
- **User**: Authentication with `has_secure_password`
  - `email` (string, required, unique)
  - `name` (string, required)
  - `password_digest` (string)
  - Has many projects

- **Project**: Basic portfolio projects
  - `title` (string, required)
  - `description` (text, required)
  - Belongs to user

### Controllers
- **ApplicationController**: Base controller with authentication helpers
  - `current_user`: Returns currently logged-in user
  - `logged_in?`: Check if user is authenticated
  - `require_login`: Before action for protected routes

- **SessionsController**: Authentication
  - `new`: Login form
  - `create`: Process login
  - `destroy`: Logout

- **UsersController**: User management
  - `new`: Registration form
  - `create`: Process registration
  - `show`: User profile

- **ProjectsController**: Project CRUD operations
  - Full RESTful actions with authentication
  - User can only access their own projects

- **HomeController**: Landing page

### Routes Structure
```ruby
root "home#index"

# Authentication
get "signup", to: "users#new"
post "signup", to: "users#create"
get "login", to: "sessions#new"
post "login", to: "sessions#create"
delete "logout", to: "sessions#destroy"

# Profile
get "profile", to: "users#show"

# Projects (RESTful resource)
resources :projects
```

### Authentication System
- Simple session-based authentication
- Uses Rails session cookies
- Password hashing with bcrypt
- No external gems required

### Views and Styling
- ERB templates with semantic HTML
- Custom CSS with modern design
- Responsive layout with mobile-first approach
- Flash message system for user feedback
- Form helpers with error handling

## Database Schema

### Users Table
```ruby
create_table :users do |t|
  t.string :email, null: false
  t.string :password_digest, null: false
  t.string :name, null: false
  t.timestamps
end
add_index :users, :email, unique: true
```

### Projects Table
```ruby
create_table :projects do |t|
  t.string :title, null: false
  t.text :description, null: false
  t.references :user, null: false, foreign_key: true
  t.timestamps
end
```

## Next Steps for Portfolio Builder

This is the minimal foundation. To build toward the drag-and-drop portfolio builder vision:

1. **Add Component System**: Create a Component model for reusable portfolio sections
2. **Layout Builder**: Implement drag-and-drop interface with Stimulus controllers
3. **Template System**: Add pre-built templates users can customize
4. **Public Portfolio Pages**: Create public-facing portfolio URLs
5. **Asset Management**: Add image uploads and media management
6. **Styling Options**: Implement theme and color customization
7. **Export Features**: Allow users to export their portfolios

## Development Guidelines

- Follow Rails conventions and MVC patterns
- Use semantic HTML and accessible markup
- Write tests for new functionality
- Keep authentication simple and secure
- Maintain responsive design principles
- Use Rails form helpers and built-in security features

## Security Features

- CSRF protection enabled
- Strong parameters for mass assignment protection
- Password hashing with bcrypt
- Session-based authentication
- User authorization (users can only access their own projects)
- Input validation and sanitization