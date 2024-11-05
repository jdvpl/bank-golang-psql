package util

import (
	"math/rand"
	"strings"
	"time"
)

func init() {
	rand.Seed(time.Now().UnixNano())
}

func RandomInt(min, max int) int {
	return min + rand.Intn(max-min+1)
}

const alphabet = "abcdefghijklmnopqrstuvwxyz"

func RandomString(n int) string {
	var result strings.Builder
	k := len(alphabet)
	for i := 0; i < n; i++ {
		c := alphabet[rand.Intn(k)]
		result.WriteByte(c)
	}
	return result.String()
}

func RandomOwner() string {
	return RandomString(6)
}

func RandomMoney() int64 {
	return int64(RandomInt(0, 1000000000))
}
func RandomCurrency() string {
	currency := []string{"USD", "EUR", "CAD", "GBP", "PES"}
	n := len(currency)
	return currency[rand.Intn(n)]
}
