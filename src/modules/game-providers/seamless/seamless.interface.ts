export interface IAdapter {
    launchGame(): Promise<void>
    syncGame(): Promise<void>
}