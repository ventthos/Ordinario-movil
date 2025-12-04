//
//  MealCardView.swift
//  examenu2
//
//  Created by user286436 on 11/20/25.
//

import SwiftUI


struct MealCardView: View {

    @EnvironmentObject var viewModel: DesignTokensViewModel

    let meal: Recipe



    var body: some View {

        ZStack(alignment: .bottomLeading) {
            // MARK: - Imagen con AsyncImage
            AsyncImage(url: URL(string: meal.imageURL)) { phase in
                switch phase {
                case .empty:

                    ZStack {

                        Color.gray.opacity(0.2)

                        ProgressView()

                    }

                case .success(let image):

                    image

                        .resizable()

                        .aspectRatio(contentMode: .fill)

                case .failure(_):

                    ZStack {

                        Color.red.opacity(0.2)

                        Image(systemName: "exclamationmark.triangle.fill")

                            .foregroundColor(.red)

                            .font(.largeTitle)

                    }

                @unknown default:

                    EmptyView()

                }

            }

            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 180)

            .clipped()

            .cornerRadius(viewModel.config?.borderTarjetas ?? 30)

            .overlay(

                RoundedRectangle(cornerRadius: 15)

                    .foregroundColor(.black.opacity(0.1))

            )



            // MARK: - Overlay de información

            VStack(spacing: 5) {

                // Icono de megáfono

                HStack {

                    Image(systemName: "megaphone.fill")

                        .font(.caption)

                        .foregroundColor(.black)

                        .padding(8)

                        .background(Color(hex: "#fccc60"))

                        .clipShape(Circle())

                    Spacer()

                }



                Spacer()

                

                // Nombre y calorías centrados

                VStack(spacing: 10) {

                    Text(meal.name)

                        .font(.headline)

                        .fontWeight(.semibold)

                        .foregroundColor(.white)

                        .lineLimit(3)

                        .multilineTextAlignment(.center)

                        .frame(maxWidth: .infinity)



                    Text("🔥 \(meal.calories) kcal")

                        .font(.subheadline)

                        .foregroundColor(.black)

                        .fontWeight(.medium)

                        .padding(.horizontal, 12)

                        .padding(.vertical, 6)

                        .background(Color.white)

                        .cornerRadius(20)

                        .frame(maxWidth: .infinity, alignment: .center)

                }



                Spacer()

                

                // Barra inferior con iconos

                HStack {
                    HStack {
                        Image("bowl")
                            .renderingMode(.template) 
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.green)
                            
                        Text(meal.servings.components(separatedBy: " ").last ?? "0")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.black.opacity(0.4))

                    .cornerRadius(20)

                    

                    Spacer()

                    

                    Image(systemName: "ellipsis")

                        .font(.subheadline)

                        .foregroundColor(.white)

                        .padding(10)

                        .background(Color.gray.opacity(0.5))

                        .clipShape(Circle())

                        .rotationEffect(.degrees(90))

                }

            }

            .padding(10)

            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)

            .background(

                LinearGradient(gradient: Gradient(colors: [.clear, .black.opacity(0.6)]),

                               startPoint: .top,

                               endPoint: .bottom)

            )

            .cornerRadius(viewModel.config?.borderTarjetas ?? 30)



        }

    }

}
