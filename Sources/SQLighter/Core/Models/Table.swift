import Foundation

struct Table {
  let name: SQLTable
  let alias: String?
  let columns: [Column]
}
