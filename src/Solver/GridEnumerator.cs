using System;
using Ardalis.GuardClauses;

namespace sudokusolver.Solver
{
        public class GridEnumerator : IGridEnumerator
        {
            private int _row = 0;
            private int _column = -1;

            public Grid Grid { get; }

            public GridEnumerator(Grid grid)
            {
                Guard.Against.Null(grid, nameof(grid));
                Grid = grid;
            }

            private void AssertValidPosition()
            {
                if (this._column < 0) 
                    throw new InvalidOperationException("must call MoveNext() before the first usage of Current or MoveBack()");
            }

            public IGridCell Current
            {
                get
                {
                    AssertValidPosition();
                    return this.Grid.Cell(this._row, this._column);
                }
            }

            public bool MoveNext()
            {
                var row = this._row;
                var col = this._column;
                col++;
                if (col >= this.Grid.Size)
                {
                    col = 0;
                    row++;
                }

                if (row >= this.Grid.Size) return false;

                this._row = row;
                this._column = col;
                return true;
            }

            public bool MoveBack()
            {
                AssertValidPosition();

                var row = this._row;
                var col = this._column;
                col--;
                if (col < 0)
                {
                    col = this.Grid.Size - 1;
                    row--;
                }

                if (row < 0) return false;

                this._row = row;
                this._column = col;
                return true;
            }

            public void Reset()
            {
                this._row = 0;
                this._column = -1;
            }
        }
}