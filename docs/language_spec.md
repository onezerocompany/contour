# **Contour Language Specification**

## **1. Overview**
The `.contour` file format defines structured schemas for data modeling. It serves as a source of truth for generating code in multiple languages such as Dart and TypeScript. `.contour` schemas support validation, modularity, and reusability through a **global scope**, where all `.contour` files within a project are combined into a unified schema space.

## **2. File Structure**
A `.contour` file consists of:
- **Schema Definitions**: Defines objects, their fields, and validation rules.
- **Modifiers & Constraints**: Specifies validation rules, optional fields, and structure constraints.
- **Global Scope**: All `.contour` files in a project are treated as part of a single schema space, eliminating the need for explicit imports.

### **Example Schema**
```contour
UserName object {
  first string {
    min(3)
    max(100)
    required // default behavior but made explicit here
  }
  last string {
    min(3)
    max(100)
  }
  strict // default behavior meaning no additional fields are allowed
}

// Describes the address of a user
UserAddress object {
  country string {
    options(
      Netherlands
      Belgium
      Germany
    )
  }
  street string {
    singleLine
    optional
  }
}

User object {
  id Identifier // this is referenced from the global scope of the project
  name UserName
  address UserAddress { optional }
  age number {
    min(0)
    max(120)
  }
  strict
}
```

## **3. Schema Definition**
### **3.1 Declaring a Schema**
Each `.contour` file defines objects using the format:
```contour
SchemaName object {
  fieldName fieldType { validationRules }
  strict // (default) prohibits additional fields
}
```

### **3.2 Supported Data Types**
| Type       | Description                                      |
|------------|-------------------------------------------------|
| `string`   | Text-based data                                |
| `number`   | Integer or floating-point numbers             |
| `boolean`  | `true` or `false` values                      |
| `array<T>` | A list of elements of type `T`                |
| `object`   | Nested structures with custom field sets      |
| `enum`     | A set of predefined string or number values   |
| `ref`      | Reference to another schema                   |

### **3.3 Validation Rules**
#### **String Validation**
```contour
first string {
  min(3)
  max(100)
  required
}
```
- `required`: Field must be present (default behavior).
- `min(x)`: Minimum character length.
- `max(x)`: Maximum character length.
- `options(...)`: Restricts allowed values.
- `singleLine`: Ensures value does not contain line breaks.

#### **Number Validation**
```contour
age number {
  min(0)
  max(120)
}
```
- `min(x)`: Minimum numeric value.
- `max(x)`: Maximum numeric value.

#### **Boolean Defaults**
```contour
isAdmin boolean {
  default(false)
}
```

#### **Object Fields & References**
Fields can reference other schemas from the **global scope**.
```contour
id Identifier // References an external schema defined anywhere in the project
```
- Objects can be reused by referencing their names.

#### **Optional Fields**
Fields can be marked as optional.
```contour
address UserAddress { optional }
```

#### **Strict Mode**
By default, schemas do not allow extra fields (`strict`). If additional fields are required, this can be explicitly relaxed.
```contour
User object {
  strict // No extra fields allowed (default)
}
```

## **4. Computed Fields**
Allows derived values based on other fields.
```contour
Invoice object {
  subtotal number
  tax number
  total number {
    computed(subtotal + tax)
  }
}
```

## **5. Conditional Validation**
Fields can define conditions based on other fields.
```contour
Product object {
  type enum("physical", "digital")
  weight number {
    requiredIf(type == "physical")
  }
}
```

## **6. Exporting & Code Generation**
The `.contour` format enables generation into target languages.
- Dart: Generates classes with type safety and validation.
- TypeScript: Generates interfaces and runtime validation functions.

## **7. Extensibility**
The specification is designed to support additional types, validation rules, and language targets in future updates.

