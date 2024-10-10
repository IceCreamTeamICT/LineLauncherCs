﻿
using LMC.Account.OAuth;
using LMC.Basic;
using LMC.Minecraft;
using LMC.Pages;
using LMC.Utils;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace LMC.Account
{
    public enum AccountType{MSA, OFFLINE, AUTHLIB};
    public class AccountManager
    {
        public static Dictionary<string, Account> RefreshedAccounts = new Dictionary<string, Account>();
    
        private static Logger s_logger = new Logger("AM");

        public static string GetKey(Account account)
        {
            if (account.Type == AccountType.MSA)
            {
                return $"{account.Uuid}_MSA";
            }
            if (account.Type == AccountType.AUTHLIB)
            {
                return $"{account.Uuid}_AUTHLIB";
            }
            else
            {
                return $"{account.Id}_Offline";
            }
        }
        public static void AddAccount(Account account, string refreshToken = null, bool onlyAddToList = false)
        {
            if(account.Type == AccountType.MSA)
            {
                if (RefreshedAccounts.ContainsKey(GetKey(account))) { RefreshedAccounts.Remove(GetKey(account)); }
                RefreshedAccounts.Add(GetKey(account), account);
                if (onlyAddToList) {
                    return;
                }
                if (refreshToken != null)
                {
                    Secrets.Write("acc_" + account.Uuid + "_" + account.Type, "refresh_token", refreshToken);
                }
                Secrets.Write("acc_" + account.Uuid + "_" + account.Type, "id", account.Id);
            }
            if (account.Type == AccountType.AUTHLIB) {
                Secrets.Write("acc_" + account.Uuid + "_" + account.Type, "authServer", account.AuthLib_authServer);
                Secrets.Write("acc_" + account.Uuid + "_" + account.Type, "authPassword", account.AuthLib_password);
                Secrets.Write("acc_" + account.Uuid + "_" + account.Type, "authAccount", account.AuthLib_account);
                Secrets.Write("acc_" + account.Uuid + "_" + account.Type, "id", account.Id);
                if (RefreshedAccounts.ContainsKey(GetKey(account))) { RefreshedAccounts.Remove(GetKey(account)); }
                RefreshedAccounts.Add(GetKey(account), account);
            }
            if (account.Type == AccountType.OFFLINE)
            {
                Secrets.Write("acc_" + account.Id + "_" + account.Type, "id", account.Id);
                if (RefreshedAccounts.ContainsKey(GetKey(account))) { RefreshedAccounts.Remove(GetKey(account)); }
                RefreshedAccounts.Add(GetKey(account), account);
            }

        }

        public static void DeleteAccount(Account account)
        {
            string section = null;
            if (account.Type == AccountType.MSA)
            {
                section = "acc_" + account.Uuid + "_" + account.Type;
                RefreshedAccounts.Remove(GetKey(account));
            }
            if (account.Type == AccountType.AUTHLIB)
            {
                section = "acc_" + account.Uuid + "_" + account.Type;
                RefreshedAccounts.Remove(GetKey(account));
            }
            if (account.Type == AccountType.OFFLINE)
            {
                section = "acc_" + account.Id + "_" + account.Type;
                RefreshedAccounts.Remove(GetKey(account));
            }
            Secrets.DeleteSection(section);

        }
        
        async public static Task DownloadSkin(Account account)
        {
            var res = await HttpUtils.GetString("https://sessionserver.mojang.com/session/minecraft/profile/" + account.Uuid);
            var base64 = JsonUtils.GetValueFromJson(res, "properties[0].value");
            string skinJson = Encoding.UTF8.GetString(Convert.FromBase64String(base64));
            string skinUrl = JsonUtils.GetValueFromJson(skinJson, "textures.SKIN.url");
            Directory.CreateDirectory("./LMC/cache/" + account.Uuid);
            Downloader downloader = new Downloader(skinUrl, "./LMC/cache/" + account.Uuid + "/skin.png");
            await downloader.DownloadFileAsync();
        }

        async public static Task<WriteableBitmap> GetAvatar(Account account)
        {
            string skinPath = "./LMC/cache/" + account.Uuid + "/skin.png";
            if (!File.Exists(skinPath))
            {
                await DownloadSkin(account);
            }
            BitmapImage skinImage = new BitmapImage();
            using (FileStream fs = new FileStream(skinPath, FileMode.Open, FileAccess.Read))
            {
                skinImage.BeginInit();
                skinImage.CacheOption = BitmapCacheOption.OnLoad;
                skinImage.StreamSource = fs;
                skinImage.EndInit();
            }

            Int32Rect headArea = new Int32Rect(8, 8, 8, 8);

            Int32Rect hatArea = new Int32Rect(40, 8, 8, 8);

            CroppedBitmap croppedHead = new CroppedBitmap(skinImage, headArea);

            CroppedBitmap croppedHat = new CroppedBitmap(skinImage, hatArea);

            WriteableBitmap finalImage = new WriteableBitmap(8, 8, skinImage.DpiX, skinImage.DpiY, PixelFormats.Pbgra32, null);

            finalImage.WritePixels(headArea, GetPixels(croppedHead), croppedHead.PixelWidth * 4, 0);

            finalImage.WritePixels(headArea, GetPixels(croppedHat), croppedHat.PixelWidth * 4, 0);

            return finalImage;
        }

        private static byte[] GetPixels(CroppedBitmap croppedBitmap)
        {
            int stride = croppedBitmap.PixelWidth * (croppedBitmap.Format.BitsPerPixel / 8);
            byte[] pixels = new byte[croppedBitmap.PixelHeight * stride];
            croppedBitmap.CopyPixels(pixels, stride, 0);
            return pixels;
        }

        async public static Task<List<Account>> GetAccounts(bool refresh)
        {
            List<Account> accounts = new List<Account>();
            var sections = Secrets.ReadSections(); 
            foreach (var section in sections)
            {
                if (section.StartsWith("acc_"))
                {
                    var arr = section.Split('_');
                    string typeStr = arr[arr.Length-1];
                    AccountType type = AccountType.OFFLINE;
                    switch(typeStr)
                    {
                        case "MSA": type= AccountType.MSA; break;
                        case "OFFLINE": type = AccountType.OFFLINE; break;
                        case "AUTHLIB": type = AccountType.AUTHLIB; break;
                    }
                    Account account = new Account();
                    account.Type = type; 
                    if (type==AccountType.OFFLINE)
                    {
                        account.Id = await Secrets.Read(section, "id");
                        accounts.Add(account);
                        AddAccount(account);
                        continue;
                    }
                    if(type==AccountType.AUTHLIB)
                    {
                        account.AuthLib_authServer = await Secrets.Read(section, "authServer");
                        account.AuthLib_password = await Secrets.Read(section, "authPassword");
                        account.AuthLib_account= await Secrets.Read(section, "authAccount");
                        account.Id = await Secrets.Read(section, "id");
                        account.Uuid = section.Substring(4).Replace("_AUTHLIB", "");
                        accounts.Add(account);
                        AddAccount(account);
                        continue;
                    }
                    if(type==AccountType.MSA)
                    {
                        if (refresh)
                        {
                            string refreshToken = await Secrets.Read(section, "refresh_token");
                            OAuth.OAuth oa = new OAuth.OAuth();
                            var tokens = await oa.RefreshToken(refreshToken);
                            Secrets.Write(section, "refresh_token", tokens.refreshToken);
                            account.AccessToken = tokens.accessToken;
                        };
                        account.Id = await Secrets.Read(section, "id");
                        account.Uuid = section.Substring(4).Replace("_MSA", "");
                        DownloadSkin(account);
                        accounts.Add(account);
                        AddAccount(account);
                    }
                }
            }
            return accounts;
        }
    }
}
