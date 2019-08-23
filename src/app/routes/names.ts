export class RouteNames {
  public static readonly HOME = '';
  public static readonly ROULETTE = 'roulette';
  public static readonly ROULETTE_ORDER = 'order';
  public static readonly ROULETTE_ORDER_FULL = RouteNames.combine(RouteNames.ROULETTE, RouteNames.ROULETTE_ORDER);
  public static readonly ROULETTE_ROLE = 'role';
  public static readonly ROULETTE_ROLE_FULL = RouteNames.combine(RouteNames.ROULETTE, RouteNames.ROULETTE_ROLE);

  public static combine(...routes: string[]): string {
    return routes.reduce((acc, v) => `${acc}/${v}`, '').substr(1);
  }
}
