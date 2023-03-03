enum PaymentStatus { paid, pending, refunded }

void main() {
  PaymentStatus paymentStatus = PaymentStatus.refunded;

  // ctrl + . to generate cases
  switch (paymentStatus) {
    case PaymentStatus.paid:
      // TODO: Handle this case.
      break;
    case PaymentStatus.pending:
      // TODO: Handle this case.
      break;
    case PaymentStatus.refunded:
      // TODO: Handle this case.
      break;
  }

  print(PaymentStatus.values[1]);
}
