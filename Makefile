migration: 
	go run cmd/migration/main.go
build:
	go build -o build ./cmd/...
clean:
	rm -rf build/*