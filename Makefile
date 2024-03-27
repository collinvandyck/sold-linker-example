run: deps
	cargo run

deps:
	scripts/deps.sh

clean:
	rm -rf sold/build/dist
