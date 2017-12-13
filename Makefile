build:
	docker build -t kaniabi/pythonbase:latest .
rebuild:
	docker build --no-cache -t kaniabi/pythonbase:latest .
push:
	docker tag kaniabi/pythonbase:latest kaniabi/pythonbase:5
	docker push kaniabi/pythonbase:5
