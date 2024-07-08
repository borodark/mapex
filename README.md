# SFO Street Food with Maps 

- Searches food by the vendor permit status and served food items
- Shows vendors details page with zoomable map centered on location of vendor service 

## Credits

- https://github.com/sntran for https://github.com/sntran/live_map
- https://github.com/elixir-explorer/explorer/graphs/contributors for Explorer 

## TODO

- [ ] https://github.com/aiwaiwa/phoenix_dark_mode
- [ ] display map and details in modal and evolve to an SPA
- [ ] `live_map` as `mix` dependency 
- [ ] add periodic refresh of local CSV from http://data.sfgov.org/resource/rqzj-sfat.csv
- [ ] tests for added functionality
- [ ] drop `Ecto` dependency


## 

To start in `docker compose`

```bash
docker compose up --remove-orphans

```

Visit [`http://localhost:4000/food_vendors`](http://localhost:4000/food_vendors) from your browser.


To start as Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).
