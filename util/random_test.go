package util

import (
	"testing"

	"github.com/stretchr/testify/require"
)

func TestRandom(t *testing.T) {
	t.Run("RandomString", func(t *testing.T) {
		n := 5
		randomString := RandomString(n)
		require.Len(t, randomString, n)
		for _, c := range randomString {
			require.Contains(t, alphabet, string(c))
		}
	})

	t.Run("RandomOwner", func(t *testing.T) {
		randomOwner := RandomOwner()
		require.Len(t, randomOwner, 6)
	})

	t.Run("RandomMoney", func(t *testing.T) {
		randomMoney := RandomMoney()
		require.True(t, randomMoney >= 0)
		require.True(t, randomMoney < 1000)
	})

	t.Run("RandomCurrency", func(t *testing.T) {
		randomCurrency := RandomCurrency()
		require.Contains(t, []string{"USD", "EUR", "CAD", "GBP", "PES"}, randomCurrency)
	})
}
