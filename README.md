# Rails Engine README

First project for Turing Backend Mod 3

Provides an api interface to a database of ecommerce information
#### Getting Started
- Run `bundle`
- Run `rake db:drop` (just for sake of thoroughness)
- Run `rake db:create`, `rake db:migrate`
- Running `rake import:all` will seed the database with the files in the csv directory

### Environment
- Ruby 2.3.7
- Rails 5.1.6.1

### Running Tests
- Run `rspec`
- To get responses directly through a web browser run `rails s` in the terminal, then navigate to `localhost:3000` with one of the following paths
###### Merchant Endpoints
  - `/api/v1/merchants/find?id=1`
  - `/api/v1/merchants/find?name=Schroeder-Jerde`
  - `/api/v1/merchants/find_all?name=Schroeder-Jerde`
  - `/api/v1/merchants/random`
  - `/api/v1/merchants/:id/items`
  - `/api/v1/merchants/:id/invoices`

### Built With
- Ruby and Rails
- Netflix fast_jsonapi
- RSpec
- Factorybot
- Faker
- Simplecov
- Pry

### Acknowledgments
- [Turing School](https://turing.io/) and the [Project Spec](http://backend.turing.io/module3/projects/rails_engine)
- [Josh Mejia](https://github.com/jmejia) and [Mike Dao](https://github.com/mikedao)
