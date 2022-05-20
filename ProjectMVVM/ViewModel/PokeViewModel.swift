import Foundation

class PokeViewModel {
    
    var pokemons = [Result]()
    
    let URL_API: String = "https://pokeapi.co/api/v2/pokemon"
    
    func getDataFromAPI() async {
        guard let url = URL(string: URL_API) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decoder = try? JSONDecoder().decode(Pokemon.self, from: data) {
                DispatchQueue.main.async(execute: {
                    decoder.results.forEach { pokemon in
                        self.pokemons.append(pokemon)
                    }
                })
            }
        } catch {
            print("error found")
        }

    }
}
