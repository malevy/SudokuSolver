namespace sudokusolver.Solver
{

    public interface IGridCell
    {
        int Row { get; }
        int Column { get; }
        int Value { get; set; }
        bool IsFrozen { get; }
        bool HasValue { get;  }
        void Restart();
    }

}