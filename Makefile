build:
	docker build -t kaniabi/pythonbase:latest .
rebuild:
	docker build --no-cache -t kaniabi/pythonbase:latest .
push:
	docker tag kaniabi/pythonbase:latest kaniabi/pythonbase:latest
	docker push kaniabi/pythonbase:latest

