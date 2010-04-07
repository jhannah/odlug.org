using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GAReversal
{
    public class Chromosome
    {

        public double fitness;

        public StringBuilder genome;

        public Chromosome(Chromosome previousChromosome)
        {
            genome = new StringBuilder();
            genome.Append(previousChromosome.genome.ToString());
            fitness = previousChromosome.fitness;
        }


        public Chromosome(StringBuilder genome, double fitness)
        {
            this.fitness = fitness;
            this.genome = genome;
        }

    }

	using System;
	using System.Collections;
	using System.Linq;
	using System.Text;
	using WindowsFormsApplication1;
	using System.Collections.Generic;

	public class Client
	{
	    public MateWorker MakeChildren(List<Chromosome> parents, double mutationRate, int elitist, double crossoverRate)
	    {
	        return new MateWorker(parents, mutationRate, elitist, crossoverRate);
	    }
	}
	    public class MateWorker : System.ComponentModel.BackgroundWorker
	    {
	        public MateWorker()
	        {
	            WorkerReportsProgress = true;
	            WorkerSupportsCancellation = true; 
	        }

	        public MateWorker(List<Chromosome> parents, double mutationRate, int elitist, double crossoverRate) : this()
	        {
	            Parents = parents;
	            MutationRate = mutationRate;
	            Elitist = elitist;
	            CrossoverRate = crossoverRate;
	        }

	        public List<Chromosome> Parents
	        {
	            get
	            {
	                return _Parents;
	            }
	            set
	            {
	                _Parents = value;
	            }
	        }
	        private List<Chromosome> _Parents;
	        public List<Chromosome> Children
	        {
	            get
	            {
	                return _Children;
	            }
	            set
	            {
	                _Children = value;
	            }
	        }
	        private List<Chromosome> _Children;

	        public double MutationRate
	        {
	            get
	            {
	                return _MutationRate;
	            }
	            set
	            {
	                _MutationRate = value;
	            }
	        }
	        private double _MutationRate;

	        public int Elitist
	        {
	            get
	            {
	                return _Elitist;
	            }
	            set
	            {
	                _Elitist = value;
	            }
	        }
	        public double CrossoverRate
	        {
	            get
	            {
	                return _CrossoverRate;
	            }
	            set
	            {
	                _CrossoverRate = value;
	            }
	        }
	        private double _CrossoverRate;

	        private int _Elitist;

	        public bool Mate() 
	        {
	            int ParentCount = Parents.Count;
	            int ChildrenCount = Children.Count;
	            Random random1 = new Random();

	            //for (int k = 0; k < (ParentCount-1-ChildrenCount); k=k+2)
	            while (Children.Count < ParentCount)
	            {

	                int parent1 = random1.Next((int)Math.Floor((double)(Parents.Count - 1)/2));
	                StringBuilder father = Parents.ElementAt(parent1).genome;
	                Parents.RemoveAt(parent1);

	                int parent2 = random1.Next((int)Math.Floor((double)(Parents.Count - 1) / 2));
	                StringBuilder mother = Parents.ElementAt(parent2).genome;
	                Parents.RemoveAt(parent2);

	                if (father.Length == mother.Length)
	                {
	                    // One point crossover

	                    int crossoverPoint1 = random1.Next(father.Length);
	                    char[] janezChar = new char[father.Length];
	                    char[] majaChar = new char[father.Length];

	                    char[] fatherChar = father.ToString().ToCharArray();
	                    char[] motherChar = mother.ToString().ToCharArray();

	                    janezChar = fatherChar;
	                    majaChar = motherChar;


	                    for (int i = 0; i < father.Length; i=i+32)
	                    {
	                        if (random1.Next(100) < CrossoverRate)
	                        {
	                            for (int j = 0; j < 32; j++)
	                            {
	                                char temp = janezChar[i + j];
	                                janezChar[i + j] = majaChar[i + j];
	                                majaChar[i + j] = temp;
	                            }
	                        }
	                    }
	                    /*
	                    if (CrossoverRate < autoRand.Next(100))
	                    {
	                        for (int i = 0; i < crossoverPoint1; i++)
	                        {
	                            janezChar[i] = fatherChar[i];
	                            majaChar[i] = motherChar[i];
	                        }
	                        for (int i = crossoverPoint1; i < fatherChar.Length; i++)
	                        {
	                            janezChar[i] = motherChar[i];
	                            majaChar[i] = fatherChar[i];
	                        }


	                    }
	                     */
	             StringBuilder jSb = new StringBuilder();
	                    StringBuilder mSb = new StringBuilder();
	                    String jjSb = new String (janezChar);
	                    String mmSb = new String (majaChar);

	                    jSb.Append(jjSb);
	                    mSb.Append(mmSb);

	                   Children.Add(Mutate(new Chromosome(jSb, 0)));
	                   Children.Add(Mutate(new Chromosome(mSb, 0)));


	                }
	                else
	                {
	                    return false;
	                }
	            }
	            if (Children.Count < 100)
	            { int i = 10 + 20; }
	            return true;
	        }

	        public bool Elite()
	        {
	            for (int i = 0; i < Elitist; i++)
	            {
	                Children.Add(Parents.ElementAt(i));
	            }
	            return true;
	        }

	        public Chromosome Mutate(Chromosome c)
	        {
	            StringBuilder child = new StringBuilder();
	            Random random1 = new Random();
	            double mutationFraction = MutationRate / 100;

	                child = c.genome;

	                for (int i = 0; i < child.Length; i++)
	                {
	                    if (random1.NextDouble() < (mutationFraction))
	                    {
	                        if (child[i] == '0')
	                        {
	                            child[i] = '1';
	                        }
	                        else
	                        {
	                            child[i] = '0';
	                        }
	                    }
	                }
	                c.genome = child;

	            return new Chromosome(c);
	        }

	        public double AverageFitness()
	        {
	            double i = 0;
	            double sum = 0;
	            Parents.ForEach(delegate(Chromosome c)
	            {
	                sum = sum + c.fitness;
	                i++;
	            });

	            return sum / i;

	        }
	        public bool Select()
	        {
	            List<Chromosome> tempParents = new List<Chromosome>();
	            Random random1 = new Random();
	            double avgFitness = AverageFitness();
	            while (tempParents.Count < Parents.Count)
	            {
	                Parents.ForEach(delegate(Chromosome c)
	                {
	                    if (tempParents.Count() < Parents.Count)
	                    {
	                        double fitnessRatio = avgFitness / c.fitness;
	                        while ((fitnessRatio) > 1)
	                        {
	                            tempParents.Add(c);
	                            fitnessRatio = fitnessRatio - 1;
	                            if (fitnessRatio > 1)
	                            {
	                                tempParents.Add(c);
	                                fitnessRatio = 0;
	                            }
	                        }
	                        if ((fitnessRatio) < 1 && fitnessRatio > 0)
	                        {
	                            if (random1.NextDouble() < fitnessRatio)
	                            {
	                                tempParents.Add(c);
	                            }
	                        }
	                    }
	                });
	            }
	            if (tempParents.Count < 100)
	            { int i = 10 + 20; }
	            Parents = tempParents;
	            return true;
	        }

	        protected override void OnDoWork(System.ComponentModel.DoWorkEventArgs e)
	        {
	            if (CancellationPending)
	            {
	                e.Cancel = true;
	                return;
	            }

	            Children = new List<Chromosome>();

	            Children.Clear();
	            this.Elite();
	            this.Select();
	            this.Mate();


	            e.Result = Children;
	        }



	    }

}
