# Wiky

Wiky is a Markov Chain random sentence generator that uses Wikipedia as the corpus.

Wiky is built using [Phoenix](https://github.com/phoenixframework/phoenix).

## Starting Up:

To start Wiky you have to:

1. Install dependencies with `mix deps.get`
2. Start Phoenix router with `mix phoenix.start`

Now you can visit `localhost:4000` from your browser.

## Screenshot

![screenshot](http://i.imgur.com/C75KIOm.png)

## Development

This project uses Coffeescript. Therefore you need to run guard to convert the files into Javascript when the coffee files change.

* `mix deps.get`
* `bundle install`
* `bundle exec guard`
* `mix phoenix.start`

## TODO

- [ ] Topic should be unique to connection
- [ ] Convert Wiky.Parser into GenServer
- [ ] Attach Wiky.Parser and Wiky.Parser.ProgressState to supervision tree.
- [X] Integrate Markov Chains project (Markovy)
- [X] Store dictionary in ETS
- [X] Generate Markov Chains from ETS

