namespace sudokusolver.Solver
{
    public interface IGridEnumerator
    {
        Grid Grid { get; }
        IGridCell Current { get; }
        bool MoveNext();
        bool MoveBack();
        void Reset();
    }
}