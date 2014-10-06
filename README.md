# Wiky

To start your new Phoenix application you have to:

1. Install dependencies with `mix deps.get`
2. Start Phoenix router with `mix phoenix.start`

Now you can visit `localhost:4000` from your browser.

## Development

This project uses Coffeescript. Therefore you need to run guard to convert the files into Javascript when the coffee files change.

* `mix deps.get`
* `bundle install`
* `bundle exec guard`
* `mix phoenix.start`

## TODO

- [ ] Topic should be unique to connection
- [ ] Merge Wiky.Parser.State with Wiky.Parser.ProgressState
- [ ] Convert Wiky.Parser into GenServer
- [ ] Attach Wiky.Parser and Wiky.Parser.ProgressState to supervision tree.
- [ ] Integrate Markov Chains project (Markovy)
- [ ] Store dictionary in HashDict
- [ ] Store dictionary in ETS
- [ ] Generate Markov Chains from ETS

