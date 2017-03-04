export class Cocktail {
  image: string;
  name: string;
  link: string;
  description: string;
  ingredients: [
    { 
      quantity: number;
      spirit_name: string;
    }
  ]
}