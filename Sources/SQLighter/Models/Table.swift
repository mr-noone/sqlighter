import Foundation

struct Table {
  let name: TableRepresentable
  let alias: String?
  let columns: [Column]
}
