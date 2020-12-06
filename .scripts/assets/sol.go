package main

import (
	"bufio"
	"fmt"
	"os"
)

var (
	writer  = bufio.NewWriter(os.Stdout)
	scanner = bufio.NewScanner(os.Stdin)
)

func init() {
	scanner.Split(bufio.ScanWords)
	scanner.Buffer(make([]byte, 1e6), 1e6)
}

func printf(f string, a ...interface{}) {
	fmt.Fprintf(writer, f, a...)
}

func sint64() int64 {
	scanner.Scan()
	bb := scanner.Bytes()
	i := int64(0)
	if bb[0] == '-' {
		for _, b := range bb[1:] {
			i *= 10
			i -= int64(b - '0')
		}
		return i
	}
	for _, b := range bb {
		i *= 10
		i += int64(b - '0')
	}
	return i
}

func suint64() uint64 {
	scanner.Scan()
	bb := scanner.Bytes()
	i := uint64(0)
	for _, b := range bb {
		i *= 10
		i += uint64(b - '0')
	}
	return i
}

func sstring() string {
	scanner.Scan()
	return scanner.Text()
}

func sbytes() []byte {
	scanner.Scan()
	return scanner.Bytes()
}

func main() {
	defer writer.Flush()

}
