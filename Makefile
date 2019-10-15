build-all: clean  generate  build-app
generate:
	go  generate ./ent
migration: 
	go run cmd/migration/main.go
build-app:
	go build -o build ./cmd/...
clean:
	rm -rf build/*