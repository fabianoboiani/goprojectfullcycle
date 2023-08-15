#build stage
FROM golang:1.21 AS build

WORKDIR /app

COPY go.mod ./

RUN go mod download

COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -o goproject

#final stage 
FROM scratch

WORKDIR /app

COPY --from=build /app/goproject ./

CMD ["./goproject"]