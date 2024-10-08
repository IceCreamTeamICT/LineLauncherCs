﻿<Page x:Class="LMC.Pages.DownloadCurrentVersionPage"
      xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
      xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
      xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
      xmlns:d="http://schemas.microsoft.com/expression/blend/2008" 
      xmlns:ui="http://schemas.lepo.co/wpfui/2022/xaml"
      xmlns:controls="clr-namespace:Wpf.Ui.Controls;assembly=Wpf.Ui"
      xmlns:local="clr-namespace:LMC"
      mc:Ignorable="d" 
      d:DesignHeight="468" d:DesignWidth="801"
      Title="DownloadCurrentVersionPage">

    <Grid>
        <controls:Button x:Name="back" Margin="10,10,0,0" VerticalAlignment="Top" Height="50" Width="50" Click="back_Click">
            <controls:SymbolIcon Symbol="ArrowStepBack20" VerticalAlignment="Center" HorizontalAlignment="Center" Width="50" Height="50" FontSize="30"/>
        </controls:Button>
        <ComboBox x:Name="opt" Margin="598,80,43,0" VerticalAlignment="Top" Width="160" SelectionChanged="opt_SelectionChanged" />
        <ComboBox x:Name="fab" Margin="598,180,43,0" VerticalAlignment="Top" Width="160" SelectionChanged="fab_SelectionChanged" />
        <ComboBox x:Name="forge" Margin="598,280,43,0" VerticalAlignment="Top" Width="160" SelectionChanged="forge_SelectionChanged" />
        <TextBox x:Name="verName"  Margin="62,81,310,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" TextChanged="verName_TextChanged" />
        <controls:Image Source="/hutao.jpg" Margin="264,203,439,170"/>
        <TextBox x:Name="dvTitle"  TextWrapping="Wrap" Text="版本信息" Margin="62,152,401,132" IsEnabled="False"/>
        <Label x:Name="verInfo" Content="" HorizontalAlignment="Left" Margin="84,192,0,0" VerticalAlignment="Top" Height="130" Width="296" FontSize="8"/>
        <controls:Button x:Name="confirm" Appearance="Primary" Content="确定" Margin="645,380,0,0" VerticalAlignment="Top" Height="60" Width="113" Click="confirm_Click"/>
        <Label x:Name="validMsg" Foreground="YellowGreen" Content="名称可用！" HorizontalAlignment="Left" Margin="62,121,0,0" VerticalAlignment="Top"/>
    </Grid>
</Page>
