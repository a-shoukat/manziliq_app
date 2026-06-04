async function generateReceiptPdf(payment) {
  // Placeholder — integrate pdf-lib in production
  return `https://storage.supabase.co/receipts/${payment.id}.pdf`;
}

module.exports = { generateReceiptPdf };
