# **Contour - A Schema Definition and Code Generation System**

## **Overview**

Contour is a schema definition system that introduces a new file format, `.contour`, which serves as a structured way to define data models—similar to JSON Schema but with its own unique format and capabilities. This schema can then be transformed into code for different programming languages, enabling strong typing and validation across various platforms.

Initially, Contour will support **Dart** and **TypeScript**, with the architecture designed to be modular, allowing future expansion to additional languages.

## **Key Features**

### **1. The `.contour` File Format**

- Defines structured data models with validation rules.
- More expressive and flexible than JSON Schema.
- Serves as a single source of truth for defining data structures across multiple languages.
- Supports **schema dependencies**, allowing `.contour` files to import and reference other schemas.

### **2. Code Generation System**

- **Dart & TypeScript Support**: Converts `.contour` schemas into Dart and TypeScript code.
- **Modular Architecture**: Easily extendable to new languages.
- **Validation Rules**: Enforce constraints at compile-time and runtime.

### **3. Modular Design for Extensibility**

- Language-specific code generation modules for easy expansion.
- Standardized interface for adding new language backends.
- **Schema Importing**: Allows `.contour` files to reference other schema definitions, ensuring modularity and reusability.

### **4. CLI & API for Usability**

- **CLI Tool**: Command-line utility for schema conversion.
- **Programmatic API**: Allows integration into custom workflows.

### **5. VS Code Extension for `.contour` Files**

To enhance the developer experience, Contour will include a **Visual Studio Code extension** with:

- **Syntax Highlighting**: Improves readability of `.contour` files.
- **Autocomplete & IntelliSense**: Provides real-time suggestions and validations.
- **Error Checking & Linting**: Detects incorrect schema definitions.
- **Schema Validation**: Ensures compliance with the `.contour` format.
- **Code Formatting**: Maintains consistency in schema files.

This extension will be built using TypeScript and published on the **VS Code Marketplace**.

## **Validators**

Contour will support a comprehensive set of validators inspired by JSON Schema:

- **Type Checking**: Ensures values match expected types (string, number, boolean, etc.).
- **Required Fields**: Enforces mandatory fields.
- **Enum Values**: Restricts field values to predefined sets.
- **Minimum & Maximum Values**: Applies constraints to numeric fields.
- **String Length Constraints**: Limits string length.
- **Pattern Matching**: Validates strings using regex.
- **Array Constraints**: Defines min/max item counts, uniqueness.
- **Nested Object Validation**: Ensures sub-objects conform to schemas.
- **Date & Time Constraints**: Enforces ISO 8601, UNIX timestamps, etc.
- **Custom Formats**: Supports email, UUID, URL validation.
- **Dependency Constraints**: Ensures required relationships between fields.
- **Conditional Validation**: Applies rules dynamically.
- **Mutual Exclusivity**: Ensures only one of a set of fields is present.
- **Computed Values**: Validates based on dependent fields.
- **Reference Validation**: Ensures conformity with external schemas.
- **Regex for Objects**: Validates object keys with regex.
- **Multi-Type Fields Consideration**: While TypeScript supports `string | number` union types, Dart does not. Alternative approaches like **sealed classes** or **custom serializers** will be used for compatibility across platforms.

These validators will be built into the `.contour` format and automatically enforced during code generation. Future updates will add more validation capabilities.

## **Tech Stack & Requirements**

- **Primary Language**: Deno (for CLI, parsing, and code generation).
- **Parsing & Transformation**: Structured AST-based approach.
- **Modular Code Generation**: Implemented as independent plugins.
- **Configurable Output**: Supports user-defined preferences.
- **Compiled Binary**: Packaged as a standalone executable via Deno’s binary compilation.
- **VS Code Extension**: Developed in TypeScript for linting, validation, and syntax support.

### **Why Deno?**

- **Modern Environment**: Familiar JavaScript/TypeScript ecosystem.
- **Security**: Built-in sandboxed execution.
- **Tooling**: Integrated testing, linting, and formatting.
- **Cross-Platform Binary Compilation**: Produces self-contained executables.

## **Deliverables**

1. **Parser & Specification for `.contour` files**.
2. **Dart & TypeScript Code Generators** as independent Deno modules.
3. **CLI Tool** for schema conversion and validation.
4. **Extensible Architecture** for additional language support.
5. **VS Code Extension** for `.contour` development.

## **Next Steps**

1. Define the `.contour` file format specification.
2. Develop the parser and AST representation.
3. Implement Dart and TypeScript code generators.
4. Build and test the CLI tool.
5. Develop and publish the VS Code extension.

---

This version now includes **schema importing** to support dependencies between `.contour` files. Let me know if further refinements are needed!

