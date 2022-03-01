class AuthException {
  String code;
  String message = '';

  AuthException({required this.code}) {
    message = _setMessageFromCode();
  }

  String _setMessageFromCode() {
    switch (code) {
      case 'email-already-in-use':
        return 'Izabrali se već postojeću email adreasu.';
      case 'invalid-email':
        return 'Email adresa nije validna';
      case 'operation-not-allowed':
      case 'user-disabled':
        return 'Vaš email je onemogućen. Pokušajte ponovo ili kontaktirajte podršku.';
      case 'weak-password':
        return 'Lozinka nije dovoljno jaka.';
      case 'user-not-found':
        return 'Nalog sa unesenim email-om ne postoji. Registrujte se pre novog pokušаја.';
      case 'wrong-password':
        return 'Pogrešna lozinka. Pokušajte ponovo.';
      default:
        return 'Desila se greška. Pokušajte ponovo.';
    }
  }
}


// ERROR CODES

// SIGN UP WITH EMAIL AND PASSWORD
// email-already-in-use
// invalid-email
// operation-not-allowed
// weak-password

// SIGN IN WITH EMAIL AND PASSWORD
// invalid-email
// user-disabled
// user-not-found
// wrong-password