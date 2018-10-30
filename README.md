# IPData

Swift library to gather information for an IP using https://ipdata.co

## Getting Started

### Setting your API Key

```
IPData.apiKey = "test"
```

or adding the `apiKey` parameter in each call

```
IPData.lookup(apiKey: "test") {
    switch $0 {
    case .success(let ip):
        print(ip)
    case .failure(let error):
        print(error)
    }
}
```

###  Looking up your own IP

```
IPData.lookup {
    switch $0 {
    case .success(let ip):
        print(ip)
    case .failure(let error):
        print(error)
    }
}
```

### Looking up a specific IP address (IPv4 or IPv6 address)

```
IPData.lookup(ip: "66.102.160.1") {
    switch $0 {
    case .success(let ip):
        print(ip)
    case .failure(let error):
        print(error)
    }
}
```


### Bulk Lookup

```
IPData.lookup(bulk: ["66.102.160.1", "100.128.0.9"]) {
    switch $0 {
    case .success(let ip):
        print(ip)
    case .failure(let error):
        print(error)
    }
}
```


### Carrier Lookup

```
IPData.carrier(ip: "66.102.160.1") {
    switch $0 {
    case .success(let ip):
        print(ip)
    case .failure(let error):
        print(error)
    }
}
```
