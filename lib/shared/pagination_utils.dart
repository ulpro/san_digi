// Utilitaires de pagination
class PaginationUtils {
  static const int defaultPageSize = 20;
  static const int defaultInitialPage = 1;

  // Calculer l'offset
  static int calculateOffset(int page, int pageSize) {
    return (page - 1) * pageSize;
  }

  // Calculer le total de pages
  static int calculateTotalPages(int totalItems, int pageSize) {
    return (totalItems / pageSize).ceil();
  }

  // Vérifier si c'est la dernière page
  static bool isLastPage(int currentPage, int totalPages) {
    return currentPage >= totalPages;
  }

  // Vérifier si c'est la première page
  static bool isFirstPage(int currentPage) {
    return currentPage <= 1;
  }
}
