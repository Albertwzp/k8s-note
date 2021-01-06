package main

import (
    "errors"
    "fmt"
    "time"
    "github.com/gomodule/redigo/redis"
    "github.com/FZambia/sentinel"
)

// Sentinel provides a way to add high availability (HA) to Redis Pool using
// preconfigured addresses of Sentinel servers and name of master which Sentinels
// monitor. It works with Redis >= 2.8.12 (mostly because of ROLE command that
// was introduced in that version, it's possible though to support old versions
// using INFO command).
//
// Example of the simplest usage to contact master "mymaster":

func newSentinelPool() *redis.Pool {
    sntnl := &sentinel.Sentinel{
        Addrs:      []string{":26379", ":26379"},
        MasterName: "mymaster",
        Dial: func(addr string) (redis.Conn, error) {
            timeout := 500 * time.Millisecond
            c, err := redis.DialTimeout("tcp", addr, timeout, timeout, timeout)
            if err != nil {
                fmt.Println("newSentinelPool sntnl.Dial() error [", err, "]")
                return nil, err
            }
            return c, nil
        },
    }
    return &redis.Pool{
        MaxIdle:     3,
        MaxActive:   64,
        Wait:        true,
        IdleTimeout: 240 * time.Second,
        Dial: func() (redis.Conn, error) {
            masterAddr, err := sntnl.MasterAddr()
            if err != nil {
                fmt.Println("newSentinelPool Dial() masterAddr error [", err, "]")
                return nil, err 
            }
            fmt.Println("MasterAddr [", masterAddr, "]")
            c, err := redis.Dial("tcp", masterAddr)
            if err != nil {
                fmt.Println("connect master addr error [", err, "]")
                return nil, err 
            }
            return c, nil
        },
        TestOnBorrow: func(c redis.Conn, t time.Time) error {
            if !sentinel.TestRole(c, "master") {
                return errors.New("Role check failed")
            } else {
                return nil
            }
        },
    }
}

func main() {
    pool := newSentinelPool()
    conn := pool.Get()
    defer conn.Close()

    err := pool.TestOnBorrow(conn, time.Now())
    if err != nil {
        return
    }

    _,err = conn.Do("SET", "k", "value")
    if err != nil {
        fmt.Println("set error")
        return
    }
    v, err := conn.Do("GET", "k")
    if err != nil {
        fmt.Println("get error")
        return
    }
    fmt.Println("v:",v)
}
