# MissingRspec

This Gem extracts RSpec files that have not yet been created.

## Installation

To use it, add it to your Gemfile:

```ruby
gem 'missing_rspec', group: :development
```

## Usage

### How to specify rails path as an argument to rake

```shell
bin/rails runner "puts Rails.root.to_s"
```

Example when rails path is /app

```shell
bin/rails missing_rspec[/app]
```

### How to specify the rails path in the environment variable

```shell
bin/rails runner "puts Rails.root.to_s"
```

Set environment variables using methods such as dot_env

Example .env file when rails path is /app

```shell
RAILS_APP_PATH=/app
```

```shell
bin/rails missing_rspec
```
## Execution example

```shell
root@be31b61b9f18:/app/missing_rspec# bin/rails missing_rspec



The following folders are targeted: ["channels", "controllers", "forms", "helpers", "jobs", "lib", "mailers", "models", "presenters", "services"]
<channels>
  └<application_cable>
     ├channel.rb
     └connection.rb
<controllers>
  ├<admin>
  │  ├allowed_sources_controller.rb
  │  ├base.rb
  │  ├sessions_controller.rb
  │  ├staff_events_controller.rb
  │  ├staff_members_controller.rb
  │  └top_controller.rb
  ├<concerns>
  │  └error_handlers.rb
  ├<customer>
  │  ├accounts_controller.rb
  │  ├base.rb
  │  ├entries_controller.rb
  │  ├messages_controller.rb
  │  ├programs_controller.rb
  │  ├replies_controller.rb
  │  ├sessions_controller.rb
  │  └top_controller.rb
  ├<staff>
  │  ├accounts_controller.rb
  │  ├base.rb
  │  ├customers_controller.rb
  │  ├entries_controller.rb
  │  ├messages_controller.rb
  │  ├passwords_controller.rb
  │  ├programs_controller.rb
  │  ├replies_controller.rb
  │  ├sessions_controller.rb
  │  └top_controller.rb
  ├application_controller.rb
  └errors_controller.rb
<forms>
  ├<admin>
  │  └login_form.rb
  ├<customer>
  │  ├account_form.rb
  │  └login_form.rb
  └<staff>
     ├change_password_form.rb
     ├customer_form.rb
     ├customer_search_form.rb
     ├entries_form.rb
     └login_form.rb
<helpers>
  ├application_helper.rb
  └staff_helper.rb
<jobs>
  └application_job.rb
<lib>
  ├html_builder.rb
  └simple_tree.rb
<mailers>
  └application_mailer.rb
<models>
  ├<concerns>
  │  ├email_holder.rb
  │  ├password_holder.rb
  │  ├personal_name_holder.rb
  │  └string_normalizer.rb
  ├address.rb
  ├application_record.rb
  ├customer.rb
  ├customer_message.rb
  ├entry.rb
  ├hash_lock.rb
  ├home_address.rb
  ├message.rb
  ├message_tag_link.rb
  ├phone.rb
  ├program.rb
  ├staff_event.rb
  ├staff_member.rb
  ├staff_message.rb
  ├tag.rb
  └work_address.rb
<presenters>
  ├address_form_presenter.rb
  ├address_presenter.rb
  ├allowed_source_presenter.rb
  ├confirming_address_form_presenter.rb
  ├confirming_customer_form_presenter.rb
  ├confirming_form_presenter.rb
  ├confirming_user_form_presenter.rb
  ├customer_form_presenter.rb
  ├customer_presenter.rb
  ├form_presenter.rb
  ├message_presenter.rb
  ├model_presenter.rb
  ├program_form_presenter.rb
  ├program_presenter.rb
  ├staff_event_presenter.rb
  ├staff_member_form_presenter.rb
  ├staff_member_presenter.rb
  └user_form_presenter.rb
<services>
  ├<admin>
  │  ├allowed_sources_deleter.rb
  ├<customer>
  │  ├authenticator.rb
  │  └entry_acceptor.rb
  └<staff>
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kayamak/missing_rspec. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/kayamak/missing_rspec).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the MissingRspec project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/kayamak/missing_rspec).
