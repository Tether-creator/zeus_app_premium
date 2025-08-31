class Biller {
  final String name;
  final String category;
  const Biller(this.name, this.category);
}

const billers = <Biller>[
  Biller('Ikeja Electric', 'Electricity'),
  Biller('Eko Electric', 'Electricity'),
  Biller('Abuja Electric', 'Electricity'),
  Biller('Port Harcourt Electric', 'Electricity'),
  Biller('Kano Electric', 'Electricity'),
  Biller('Enugu Electric', 'Electricity'),
  Biller('Jos Electric', 'Electricity'),
  Biller('Ibadan Electric', 'Electricity'),
  Biller('Kaduna Electric', 'Electricity'),
  Biller('DStv', 'TV'),
  Biller('GOtv', 'TV'),
  Biller('Startimes', 'TV'),
  Biller('WAEC', 'Education'),
  Biller('JAMB', 'Education'),
  Biller('Lagos Water', 'Utilities'),
];
