//
//  RemoveRecipe.swift
//  BakeApp
//
//  Created by Alex Moran on 6/9/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import SwiftUI

protocol DeleteDelegate {
    func externalDelete(recipe:String)
}

struct RemoveRecipe: View, DeleteDelegate {
    //    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var userSettings = UserSettings()
    @State var showAlert = true
    //    @State var currentIndexOffset:Int = 0
    //    @State var indexesRemoved:[Int] = []
    //    @State var secondIndex:[Int] = []
    @State private var practiceRecipes:[Recipe]? = recipeData
        .enumerated()
        .filter { !((defaults.array(forKey: K.Defaults.removedRecipeIndex) as! Array).contains($0.offset)) }
        .map { $0.element }
    
    @State var searchText:String = ""
    var body: some View {
        VStack{
            SearchBar(text: $searchText, placeholder: "Find recipe...")
            
            List {
                ForEach((practiceRecipes?.filter({ searchText.isEmpty ? true : $0.name.lowercased().contains(searchText.lowercased()) }))!, id: \.self) { recipe in
                    NavigationLink(destination: RecipeDetail(recipe:recipe, practiceArray: self.$practiceRecipes, remove:true, deleteDelegate:self)) {
                        RecipeTile(recipe: recipe)
                    }
                    
                }
            }
        }.navigationBarTitle("Remove Recipes")
    }
    
    
    //    func delete(at offsets: IndexSet) {
    //        //get index number in recipeData
    //
    //
    //        var isLessThanAll = false
    //        if indexesRemoved.count > 0 {
    //            for item in indexesRemoved {
    //                if offsets.min()! >= item {
    //                    currentIndexOffset += 1
    //                }
    //            }
    //
    //            if currentIndexOffset == 0 || offsets.min()! == 0 {
    //                for counter in 0..<secondIndex.count {
    //                    print("less than all indexes; subtracting 1 for future reference")
    //                    indexesRemoved[counter] -= 1
    //                }
    //            }
    //        }
    //
    //        print("\(indexesRemoved)")
    //
    //
    //        alert(isPresented: $showAlert) { () -> Alert in
    //            Alert(title: Text("Are you sure you want to delete this?"), message: Text("There is no undo"), primaryButton: .destructive(Text("Delete")) {
    //                let recipeDataIndex = offsets.min()!+self.currentIndexOffset
    //
    //                self.indexesRemoved.append(offsets.min()!)
    //                print("current index offset: \(self.currentIndexOffset)")
    //
    //                           print("Real index in recipeData: \(recipeDataIndex); recipe \(recipeData[recipeDataIndex].name)")
    //
    //                self.userSettings.removedRecipeIndex.append(recipeDataIndex)
    //                self.practiceRecipes?.remove(atOffsets: offsets)
    //            }, secondaryButton: .cancel())
    //        }
    //
    //        currentIndexOffset = 0
    //    }
    
    func externalDelete(recipe:String) {
        var index:Int?
        var recipeDataIndex:Int?
        for counter in 0..<practiceRecipes!.count {
            if recipe == practiceRecipes?[counter].name {
                print("found recipe to delete: \(practiceRecipes![counter].name)")
                index = counter
            }
        }
        
        for counter in 0..<recipeData.count {
            if recipe == recipeData[counter].name {
                recipeDataIndex = counter
            }
        }
        
        if let realIndex = index {
            print("found valid index...deleting recipe")
            userSettings.removedRecipeIndex.append(recipeDataIndex!)
            practiceRecipes?.remove(at: realIndex)
            print("recipe deleted")
        }
    }
}


struct TempView: View {
    @State private var users = ["Paul", "Taylor", "Adele"]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users, id: \.self) { user in
                    Text(user)
                }
                
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        users.remove(atOffsets: offsets)
    }
}

struct RemoveRecipe_Previews: PreviewProvider {
    static var previews: some View {
        RemoveRecipe()
    }
}
