﻿<Window
        x:Class="LMC.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:ui="http://schemas.lepo.co/wpfui/2022/xaml"
        xmlns:controls="clr-namespace:Wpf.Ui.Controls;assembly=Wpf.Ui"
        xmlns:local="clr-namespace:LMC"
        mc:Ignorable="d"
        ContentRendered="WindowRendered"
        Title="Line Minecraft launCher"
        Height="518" Width="886" Icon="/ico.png" ResizeMode="NoResize" AllowsTransparency="True" WindowStyle="None" >
    <Grid Background="#FF1D1D1D">
        <ui:NavigationView PaneDisplayMode="LeftFluent" TabIndex="0"
            IsPaneVisible="True"
            TitleBar="{Binding ElementName=TitleBar, Mode=OneWay}"
            x:Name="nagv" >

            <ui:NavigationView.MenuItems>
                <ui:NavigationViewItem
                     Content="主页"
                     NavigationCacheMode="Enabled"
                     x:Name="homevi" VerticalAlignment="Center" Margin="0,70,0,0" Width="75" Height="75"  
                     TargetPageType="{x:Type local:HomePage}" 
                    >
                    <ui:NavigationViewItem.Icon>
                        <ui:SymbolIcon Symbol="Home24" />
                    </ui:NavigationViewItem.Icon>
                </ui:NavigationViewItem>

                <ui:NavigationViewItem
                     Content="账号"
                     NavigationCacheMode="Enabled"
                     x:Name="accountvi" VerticalAlignment="Top" Width="75" Height="75" 
                     TargetPageType="{x:Type local:AccountPage}">
                    <ui:NavigationViewItem.Icon>
                        <ui:SymbolIcon Symbol="People24" />
                    </ui:NavigationViewItem.Icon>
                </ui:NavigationViewItem>
                <ui:NavigationViewItem
                     Content="下载"
                     NavigationCacheMode="Enabled"
                     x:Name="downloadvi" VerticalAlignment="Center" Margin="0,0,0,0" Width="75" Height="75" 
                     TargetPageType="{x:Type local:DownloadPage}">
                    <ui:NavigationViewItem.Icon>
                        <ui:SymbolIcon Symbol="ArrowCircleDown24" />
                    </ui:NavigationViewItem.Icon>
                </ui:NavigationViewItem>

                <ui:NavigationViewItem
                     Content="管理"
                     NavigationCacheMode="Enabled"
                     x:Name="managevi" VerticalAlignment="Center" Margin="0,0,0,0" Width="75" Height="75" >
                    <ui:NavigationViewItem.Icon>
                        <ui:SymbolIcon Symbol="Archive24" />
                    </ui:NavigationViewItem.Icon>
                </ui:NavigationViewItem>

                <ui:NavigationViewItem
                     Content="设置"
                     NavigationCacheMode="Enabled"
                     x:Name="settingvi" VerticalAlignment="Center" Margin="0,75,0,0">
                    <ui:NavigationViewItem.Icon>
                        <ui:SymbolIcon Symbol="Settings24" />
                    </ui:NavigationViewItem.Icon>
                </ui:NavigationViewItem>
            </ui:NavigationView.MenuItems>
        </ui:NavigationView>
        <Image HorizontalAlignment="Left" Height="100" Margin="-15,-15,0,0" VerticalAlignment="Top" Width="100" Source="/LMC.png" Stretch="UniformToFill"/>
        <ui:TitleBar
            x:Name="TitleBar"
            Width="886"
            Height="40"
            CloseWindowByDoubleClickOnIcon="False" HorizontalAlignment="Right" CanMaximize="False" ShowMaximize="False" />
        <Label Content="Line Minecraft launCher" HorizontalAlignment="Left" Margin="78,15,0,0" VerticalAlignment="Top"/>
        <ui:InfoBar x:Name="ib" Title="" Message="" Margin="70,450,0,0" Height="120" Width="750"/>
        <ContentPresenter x:Name="ContentDialogPresenter" Grid.Row="0"/>
        <controls:Button x:Name="dipButton" Content="下载进度" Margin="1,404,0,0" VerticalAlignment="Top" Click="dipButton_Click"/>
    </Grid>
</Window>
