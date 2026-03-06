using System.Windows;
using System.Windows.Controls;
using NetPhantom.ViewModels;

namespace NetPhantom;

public partial class MainWindow : Window
{
    public MainWindow()
    {
        InitializeComponent();
    }

    private void NavigationListBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
    {
        if (DataContext is MainViewModel vm)
        {
            vm.IsDrawerOpen = false;
        }
    }
}
