// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetAllPokemonsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetAllPokemons {
      pokemons(first: 100) {
        __typename
        number
        name
        classification
        types
        evolutions {
          __typename
          number
          name
        }
        image
      }
    }
    """

  public let operationName: String = "GetAllPokemons"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("pokemons", arguments: ["first": 100], type: .list(.object(Pokemon.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(pokemons: [Pokemon?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "pokemons": pokemons.flatMap { (value: [Pokemon?]) -> [ResultMap?] in value.map { (value: Pokemon?) -> ResultMap? in value.flatMap { (value: Pokemon) -> ResultMap in value.resultMap } } }])
    }

    public var pokemons: [Pokemon?]? {
      get {
        return (resultMap["pokemons"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Pokemon?] in value.map { (value: ResultMap?) -> Pokemon? in value.flatMap { (value: ResultMap) -> Pokemon in Pokemon(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Pokemon?]) -> [ResultMap?] in value.map { (value: Pokemon?) -> ResultMap? in value.flatMap { (value: Pokemon) -> ResultMap in value.resultMap } } }, forKey: "pokemons")
      }
    }

    public struct Pokemon: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Pokemon"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("number", type: .scalar(String.self)),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("classification", type: .scalar(String.self)),
          GraphQLField("types", type: .list(.scalar(String.self))),
          GraphQLField("evolutions", type: .list(.object(Evolution.selections))),
          GraphQLField("image", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(number: String? = nil, name: String? = nil, classification: String? = nil, types: [String?]? = nil, evolutions: [Evolution?]? = nil, image: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Pokemon", "number": number, "name": name, "classification": classification, "types": types, "evolutions": evolutions.flatMap { (value: [Evolution?]) -> [ResultMap?] in value.map { (value: Evolution?) -> ResultMap? in value.flatMap { (value: Evolution) -> ResultMap in value.resultMap } } }, "image": image])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The identifier of this Pokémon
      public var number: String? {
        get {
          return resultMap["number"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "number")
        }
      }

      /// The name of this Pokémon
      public var name: String? {
        get {
          return resultMap["name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      /// The classification of this Pokémon
      public var classification: String? {
        get {
          return resultMap["classification"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "classification")
        }
      }

      /// The type(s) of this Pokémon
      public var types: [String?]? {
        get {
          return resultMap["types"] as? [String?]
        }
        set {
          resultMap.updateValue(newValue, forKey: "types")
        }
      }

      /// The evolutions of this Pokémon
      public var evolutions: [Evolution?]? {
        get {
          return (resultMap["evolutions"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Evolution?] in value.map { (value: ResultMap?) -> Evolution? in value.flatMap { (value: ResultMap) -> Evolution in Evolution(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Evolution?]) -> [ResultMap?] in value.map { (value: Evolution?) -> ResultMap? in value.flatMap { (value: Evolution) -> ResultMap in value.resultMap } } }, forKey: "evolutions")
        }
      }

      public var image: String? {
        get {
          return resultMap["image"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "image")
        }
      }

      public struct Evolution: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Pokemon"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("number", type: .scalar(String.self)),
            GraphQLField("name", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(number: String? = nil, name: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "Pokemon", "number": number, "name": name])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The identifier of this Pokémon
        public var number: String? {
          get {
            return resultMap["number"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "number")
          }
        }

        /// The name of this Pokémon
        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }
      }
    }
  }
}
