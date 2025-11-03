# dialect

An English-language wrapper for the [dialeto](https://github.com/angelonuffer/dialeto) grammar parser/generator library, implemented in [language 0](https://github.com/angelonuffer/0).

## Overview

This library provides an English API to the Portuguese-language `dialeto` library, which implements a grammar-based parser and generator. The wrapper:

1. **Exposes an English API** (`analyze`/`generate`) instead of Portuguese (`analisar`/`gerar`)
2. **Translates grammar keys** from English to Portuguese
3. **Translates result keys** from Portuguese to English
4. **Delegates all work** to the underlying `dialeto` library

## Requirements

- Node.js version 20 or higher
- The language-0 interpreter from [github.com/angelonuffer/0](https://github.com/angelonuffer/0)
- The dialeto library from [github.com/angelonuffer/dialeto](https://github.com/angelonuffer/dialeto)

## Installation

Clone the repository and its dependencies:

```bash
git clone https://github.com/angelonuffer/dialect.git
cd dialect
git clone https://github.com/angelonuffer/0.git deps/0
git clone https://github.com/angelonuffer/dialeto.git deps/dialeto
```

## Usage

### Importing the Library

```0
dialect = code/0
```

### API

#### `dialect.analyze`

Analyzes input text according to a grammar specification.

**Parameters:**
- `input` (text) - The input text to analyze
- `grammar` (object) - The grammar specification (see Grammar Types below)

**Returns:**
- `success` (number) - 1 if successful, 0 if failed
- `value` (text | list | object) - The parsed value (if successful)
- `pos` (number) - Position where parsing failed (if failed)
- `expected` (text) - What was expected (if failed)
- `found` (text) - What was found (if failed)

**Example:**

```0
result = dialect.analyze({
  input: "hello"
  grammar: {
    type: "symbol"
    text: "hello"
  }
})
```

#### `dialect.generate`

Generates output text from a value according to a grammar specification.

**Parameters:**
- `value` (text | list | object) - The value to generate from
- `grammar` (object) - The grammar specification

**Returns:**
- `success` (number) - 1 if successful, 0 if failed
- `output` (text) - The generated output (if successful)

**Example:**

```0
result = dialect.generate({
  value: "test"
  grammar: {
    type: "symbol"
    text: "test"
  }
})
```

### Grammar Types

#### Symbol

Matches/generates an exact text string.

```0
{
  type: "symbol"
  text: "hello"
}
```

#### Range

Matches/generates a single character within a range.

```0
{
  type: "range"
  from: "a"
  to: "z"
}
```

#### Sequence

Matches/generates a sequence of grammar elements.

```0
{
  type: "sequence"
  parts: [
    { type: "symbol" text: "a" }
    { type: "symbol" text: "b" }
  ]
  format: "text"  // or "list" or "object"
}
```

For `format: "object"`, each part should have a `name` and `grammar`:

```0
{
  type: "sequence"
  parts: [
    { name: "first" grammar: { type: "symbol" text: "a" } }
    { name: "second" grammar: { type: "symbol" text: "b" } }
  ]
  format: "object"
}
```

#### Alternative

Matches/generates one of several options.

```0
{
  type: "alternative"
  options: [
    { type: "symbol" text: "hello" }
    { type: "symbol" text: "world" }
  ]
}
```

#### Optional

Matches/generates an optional element.

```0
{
  type: "optional"
  grammar: { type: "symbol" text: "x" }
}
```

#### Repetition

Matches/generates repeated elements.

```0
{
  type: "repetition"
  grammar: { type: "symbol" text: "a" }
  format: "text"  // or "list"
  minimum: 1      // optional, default 1
  maximum: 5      // optional, omit for unlimited
}
```

## Examples

See the `examples/` directory for practical examples:

```bash
# Run the identifier parser example
node deps/0/código/0_node.js examples/identifier_parser.0 test
```

## Running Tests

```bash
# Run basic tests
node deps/0/código/0_node.js tests/basic_test.0 test

# Run all grammar types test
node deps/0/código/0_node.js tests/all_types_test.0 test

# Run object format test
node deps/0/código/0_node.js tests/object_format_test.0 test
```

## Implementation Details

### Translation Mappings

**Grammar Types:**
- `symbol` → `símbolo`
- `range` → `faixa`
- `sequence` → `sequência`
- `alternative` → `alternativa`
- `optional` → `opcional`
- `repetition` → `repetição`

**Grammar Keys:**
- `type` → `tipo`
- `text` → `texto`
- `from` → `de`
- `to` → `até`
- `parts` → `partes`
- `format` → `formato`
- `options` → `opções`
- `grammar` → `gramática`
- `minimum` → `minimo`
- `maximum` → `maximo`
- `name` → `nome`

**Format Values:**
- `text` → `texto`
- `list` → `lista`
- `object` → `objeto`

**Result Keys:**
- `success` ← `sucesso`
- `value` ← `valor`
- `output` ← `saída`
- `pos` ← `pos`
- `expected` ← `esperado`
- `found` ← `encontrado`

## License

This project follows the same license as the underlying dialeto and language-0 projects.

## Credits

- Language 0: [github.com/angelonuffer/0](https://github.com/angelonuffer/0)
- Dialeto: [github.com/angelonuffer/dialeto](https://github.com/angelonuffer/dialeto)
- Created by Ângelo Otávio Nuffer Nunes