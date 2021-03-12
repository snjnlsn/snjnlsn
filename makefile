NGROK_HOST := $$(curl --silent http://127.0.0.1:4040/api/tunnels | jq '.tunnels[0].public_url' | tr -d '"' | awk -F/ '{print $$3}')


.PHONY: serve-ngrok
serve-ngrok: ## Start Phoenix bound to ngrok address
	@echo "🌍 Exposing My App @ https://$(NGROK_HOST)"
	env HOST=$(NGROK_HOST) mix phx.server